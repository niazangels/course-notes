from pathlib import Path
import pandas as pd
import numpy as np
import pipeline

PACKAGE_ROOT = Path(__file__).resolve().parent
TRAIN_MODEL_DIR = PACKAGE_ROOT / "trained_models"
DATASET_DIR = PACKAGE_ROOT / "datasets"

TRAIN_FILE = DATASET_DIR / "train.csv"
TEST_FILE = DATASET_DIR / "test.csv"
TARGET = "SalePrice"

FEATURES = [
    "MSSubClass",
    "MSZoning",
    "Neighborhood",
    "OverallQual",
    "OverallCond",
    "YearRemodAdd",
    "RoofStyle",
    "BsmtQual",
    "BsmtExposure",
    "HeatingQC",
    "CentralAir",
    "1stFlrSF",
    "GrLivArea",
    "BsmtFullBath",
    "KitchenQual",
    "Fireplaces",
    "FireplaceQu",
    "GarageType",
    "GarageFinish",
    "GarageCars",
    "PavedDrive",
    # This variable is only to calculate elapsed time
    "YrSold",
]

from sklearn.model_selection import train_test_split


def save_pipeline() -> None:
    """
    Persist the pipeline
    """
    data = pd.read_csv(TRAIN_FILE)
    X_train, X_test, y_train, y_test = train_test_split(
        data[FEATURES], data[TARGET], test_size=0.1, random_state=0
    )

    # Log transform both prices
    y_train = np.log(y_train)
    y_test = np.log(y_test)

    pipeline.price_pipe.fit(X_train[FEATURES], y_train)

    save_pipeline(pipeline_to_persist=pipeline.pricepipe)


def run_training() -> None:
    """
    Train the model
    """
    print("Training")
    pass


if __name__ == "__main__":
    run_training()
