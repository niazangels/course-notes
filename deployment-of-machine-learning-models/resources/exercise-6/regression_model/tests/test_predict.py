import math

from regression_model.predict import make_prediction
from regression_model.processing.data_management import load_dataset


def test_make_single_prediction():
    test_data = load_dataset(file_name="test.csv")
    single_test_json = test_data[0:1].to_json(orient="records")

    subject = make_prediction(single_test_json)

    assert subject is not None
    assert isinstance(subject.get("predictions")[0], float)
    assert math.ceil(subject.get("predictions")[0]) == 112476
