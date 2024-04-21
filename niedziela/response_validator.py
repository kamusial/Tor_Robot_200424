from datetime import datetime
from pydantic import BaseModel


class Rate(BaseModel):
    currency: str
    code: str
    mid: float


class TableA(BaseModel):
    table: str
    no: str
    effectiveDate: datetime
    rates: list[Rate]


def validate_table_a_structure(response):
    dictionary = response.json()[0]
    TableA(**dictionary)
