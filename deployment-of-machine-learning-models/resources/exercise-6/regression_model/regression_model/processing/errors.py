class ModelError(Exception):
    """
        Base class for all model related errors
    """

    pass


class InvalidInputToModel(ModelError):
    """
        Raised when input data contains unexpected/illegal values
    """

    pass
