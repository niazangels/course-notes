import pandas as pd
from sklearn.base import BaseEstimator, TransformerMixin
from typing import List


class CategoricalImputer(BaseEstimator, TransformerMixin):
    """
        Categorical missing data imputer
    """

    def __init__(self, variables: List[str] = None):
        self.variables = variables

    def fit(self, X: pd.DataFrame, y: pd.DataFrame) -> CategoricalImputer:
        """
        Fit statement to accomodate the pipeline"
        
        Arguments:
            X {pd.DataFrame} -- features
            y {pd.DataFrame} -- target
        
        Returns:
            CategoricalImputer -- Estimator object to be passed down the pipeline
        """
        return self

    def transform(self, X: pd.Dataframe):
        """Apply the transformation to a dataframe
        
        Arguments:
            X {pd.Dataframe} -- features
        """
        X = X.copy()
        for column in self.variables:
            X[column] = X[column].fillna("Missing")
        return X
