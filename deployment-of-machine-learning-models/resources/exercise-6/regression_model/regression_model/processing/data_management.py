import joblib
import pandas as pd
from sklearn.pipeline import Pipeline

from regression_model.config import config


def load_dataset(file_name: str) -> pd.DataFrame:
    return pd.read_csv(f"{config.DATASET_DIR/file_name}")


def save_pipeline(pipeline, filename="regression_model.pkl") -> None:
    save_path = f"{config.TRAINED_MODEL_DIR}/filename"
    joblib.dump(pipeline, save_path)
    print(f"Pipeline was saved to {save_path}")


def load_pipeline(file_name: str) -> Pipeline:
    file_path = config.TRAINED_MODEL_DIR / file_name
    return joblib.load(filename=file_path)
