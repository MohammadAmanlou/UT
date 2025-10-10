from datetime import datetime, timedelta
from dateutil.relativedelta import relativedelta
import re

def parse_relative_time(relative_time, reference_time):
    try:
        if relative_time == 'N/A':
            return 'N/A'
        relative_time = relative_time.lower().strip()
        if 'just now' in relative_time or 'minutes ago' in relative_time:
            return reference_time.strftime('%Y-%m-%d %H:%M:%S')
        match = re.match(r'(\d+)\s*(hour|hours|day|days|week|weeks|month|months|year|years)\s*ago', relative_time)
        if not match:
            return 'N/A'
        number, unit = int(match.group(1)), match.group(2)
        if unit in ['hour', 'hours']:
            delta = timedelta(hours=number)
        elif unit in ['day', 'days']:
            delta = timedelta(days=number)
        elif unit in ['week', 'weeks']:
            delta = timedelta(weeks=number)
        elif unit in ['month', 'months']:
            delta = relativedelta(months=number)
        elif unit in ['year', 'years']:
            delta = relativedelta(years=number)
        else:
            return 'N/A'
        absolute_time = reference_time - delta
        return absolute_time.strftime('%Y-%m-%d %H:%M:%S')
    except Exception as e:
        print(f"Error parsing relative time '{relative_time}': {e}")
        return 'N/A'