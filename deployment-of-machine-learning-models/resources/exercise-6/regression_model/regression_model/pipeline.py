from sklearn.linear_model import Lasso
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import MinMaxScaler
from regression_model import preprocessors
from regression_model import features
from regression_model.config import config


price_pipe = Pipeline(
    [
        (
            "categorical_imputer",
            preprocessors.CategoricalImputer(variables=config.CATEGORICAL_VARS_WITH_NA),
        ),
        (
            "numerical_inputer",
            preprocessors.NumericalImputer(variables=config.NUMERICAL_VARS_WITH_NA),
        ),
        (
            "temporal_variable",
            preprocessors.TemporalVariableEstimator(
                variables=config.TEMPORAL_VARS,
                reference_variable=config.TEMPORAL_REFERENCE_VARS,
            ),
        ),
        (
            "rare_label_encoder",
            preprocessors.RareLabelCategoricalEncoder(
                tol=0.01, variables=config.CATEGORICAL_VARS
            ),
        ),
        (
            "categorical_encoder",
            preprocessors.CategoricalEncoder(variables=config.CATEGORICAL_VARS),
        ),
        (
            "log_transformer",
            features.LogTransformer(variables=config.NUMERICALS_LOG_VARS),
        ),
        (
            "drop_features",
            preprocessors.DropUnecessaryFeatures(
                variables_to_drop=config.DROP_FEATURES
            ),
        ),
        ("scaler", MinMaxScaler()),
        ("Linear_model", Lasso(alpha=0.005, random_state=0)),
    ]
)
