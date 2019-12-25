import pandas as pd
import numpy as np
from sklearn.base import BaseEstimator, TransformerMixin
from typing import List


class CategoricalImputer(BaseEstimator, TransformerMixin):
    """
        Categorical missing data imputer
    """

    def __init__(self, variables: List[str] = []):
        self.variables = variables

    def fit(self, X: pd.DataFrame, y: pd.DataFrame) -> "CategoricalImputer":
        """
        Fit statement to accomodate the pipeline"
        
        Arguments:
            X {pd.DataFrame} -- features
            y {pd.DataFrame} -- target
        
        Returns:
            CategoricalImputer -- Estimator object to be passed down the pipeline
        """
        return self

    def transform(self, X: pd.DataFrame) -> pd.DataFrame:
        """Apply the transformation to a dataframe
        
        Arguments:
            X {pd.DataFrame} -- features
        """
        X = X.copy()
        for column in self.variables:
            X[column] = X[column].fillna("Missing")
        return X


class NumericalImputer(BaseEstimator, TransformerMixin):
    """Numerical missing value imputer."""

    def __init__(self, variables=None):
        self.variables = variables

    def fit(self, X, y=None):
        # persist mode in a dictionary
        self.column_mode = {}
        for column in self.variables:
            self.column_mode[column] = X[column].mode()[0]
        return self

    def transform(self, X):
        X = X.copy()
        for column in self.variables:
            X[column].fillna(self.column_mode[column], inplace=True)
        return X


class TemporalVariableEstimator(BaseEstimator, TransformerMixin):
    """Temporal variable calculator."""

    def __init__(self, variables=None, reference_variable=None):
        self.variables = variables
        self.reference_variable = reference_variable

    def fit(self, X, y=None):
        # we need this step to fit the sklearn pipeline
        return self

    def transform(self, X):
        X = X.copy()
        for feature in self.variables:
            X[feature] = X[feature] - X[self.reference_variable]
        return X


class RareLabelCategoricalEncoder(BaseEstimator, TransformerMixin):
    """Rare label categorical encoder"""

    def __init__(self, tol=0.05, variables=None):
        self.tol = tol
        self.variables = variables

    def fit(self, X, y=None):
        # persist frequent labels in dictionary
        self.encoder_dict_ = {}
        for column in self.variables:
            # the encoder will learn the most frequent categories
            t = pd.Series(X[column].value_counts() / np.float(len(X)))
            # frequent labels:
            self.encoder_dict_[column] = list(t[t >= self.tol].index)

        return self

    def transform(self, X):
        X = X.copy()
        for column in self.variables:
            X[column] = np.where(
                X[column].isin(self.encoder_dict_[column]), X[column], "Rare"
            )

        return X


class CategoricalEncoder(BaseEstimator, TransformerMixin):
    """String to numbers categorical encoder."""

    def __init__(self, variables: list = None):
        self.variables = variables

    def fit(self, X, y):
        temp = pd.concat([X, y], axis=1)
        temp.columns = list(X.columns) + ["target"]

        # persist transforming dictionary
        self.encoder_dict_ = {}

        for var in self.variables:
            t = temp.groupby([var])["target"].mean().sort_values(ascending=True).index
            self.encoder_dict_[var] = {k: i for i, k in enumerate(t, 0)}

        return self

    def transform(self, X):
        # encode labels
        X = X.copy()
        for feature in self.variables:
            X[feature] = X[feature].map(self.encoder_dict_[feature])

        # check if transformer introduces NaN
        if X[self.variables].isnull().any().any():
            null_counts = X[self.variables].isnull().any()
            vars_ = {
                key: value for (key, value) in null_counts.items() if value is True
            }
            raise ValueError(
                f"Categorical encoder has introduced NaN when "
                f"transforming categorical variables: {vars_.keys()}"
            )

        return X


class DropUnecessaryFeatures(BaseEstimator, TransformerMixin):
    def __init__(self, variables_to_drop):
        self.variables_to_drop = variables_to_drop

    def fit(self, X, y):
        return self

    def transform(self, X):
        # encode labels
        X = X.copy()
        X = X.drop(self.variables_to_drop, axis=1)

        return X
