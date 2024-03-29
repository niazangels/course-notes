import numpy as np
import pandas as pd

from regression_model.processing.data_management import load_pipeline
from regression_model.config import config
from regression_model.processing.validation import validate_inputs
from sklearn.pipeline import Pipeline

pipeline_filename = "regression_model.pkl"
_price_pipeline: Pipeline = load_pipeline(pipeline_filename)


def make_prediction(data: dict) -> dict:
    data = pd.read_json(data)
    validated_data = validate_inputs(data[config.FEATURES])
    prediction = _price_pipeline.predict(validated_data)
    output = np.exp(prediction)
    response = {"predictions": output}
    return response
