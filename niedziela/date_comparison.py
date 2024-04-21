from datetime import datetime


def is_date_within_range(date, start_date, end_date):
    rate_date = datetime.strptime(date, "%Y-%m-%d")
    start_date = datetime.strptime(start_date, "%Y-%m-%d")
    end_date = datetime.strptime(end_date, "%Y-%m-%d")

    if start_date <= rate_date <= end_date:
        return True
    else:
        return False
