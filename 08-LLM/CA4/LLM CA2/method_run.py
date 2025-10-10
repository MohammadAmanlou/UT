import json
import time
from tqdm import tqdm
from db_manager import DBManager
from evaluation import original_bird_evaluation

def run_method(function_template, SLEEP_TIME=30, mode="dev"):
    BIRD_OUTPUT_PATH = "data/predict_data.json"

    db = DBManager()
    if mode == "dev":
        with open("data/dataset.json", "r") as f:
            data = json.load(f)
    else:
        with open("nano-data/dataset.json", "r") as f:
            data = json.load(f)


    results = []
    for item in tqdm(data):
        item_result = function_template(item)
        results.append(item_result)
        time.sleep(SLEEP_TIME)

    new_list = sorted([(item["question_id"], item["sql"] + "\t----- bird -----\t" + item["db_id"]) for item in results])
    new_list = [[index, item[1]] for index, item in enumerate(new_list)]
    bird_output_dict = {item[0]:item[1] for item in new_list}

    with open(BIRD_OUTPUT_PATH, "w") as f:
        f.write(json.dumps(bird_output_dict, indent=4))
    
    BIRD_OUTPUT_PATH = "data/"
    if mode == "dev":
        original_bird_evaluation(BIRD_OUTPUT_PATH, base_path="data")
    else:
        original_bird_evaluation(BIRD_OUTPUT_PATH, base_path="nano-data")