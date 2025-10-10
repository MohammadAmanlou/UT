import subprocess

def original_bird_evaluation(predicted_sql_path, base_path="data"):
    config = {
        "db_root_path": f"./{base_path}/dev_databases/",
        "data_mode": "data",
        "diff_json_path": f"./{base_path}/dataset.json",
        "predicted_sql_path": predicted_sql_path,
        "ground_truth_path": f"./{base_path}/",
        "num_cpus": 10,
        "meta_time_out": 20.0,
        "mode_gt": "gt",
        "mode_predict": "gpt"
    }

    print("Starting to compare without knowledge for ex")

    command = [
        "python", "-u", "./evaluation/evaluation.py",
        "--db_root_path", config["db_root_path"],
        "--predicted_sql_path", config["predicted_sql_path"],
        "--data_mode", config["data_mode"],
        "--ground_truth_path", config["ground_truth_path"],
        "--num_cpus", str(config["num_cpus"]),
        "--mode_gt", config["mode_gt"],
        "--mode_predict", config["mode_predict"],
        "--diff_json_path", config["diff_json_path"],
        "--meta_time_out", str(config["meta_time_out"])
    ]

    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()
    if process.returncode == 0:
        print("Process finished successfully")
    else:
        print(f"Process finished with return code {process.returncode}")
        print(f"Error: {stderr.decode()}")
    print(stdout.decode())
    return stdout.decode()


if __name__ == "__main__":
    # Example usage
    predicted_sql_path = "./data/"
    result = original_bird_evaluation(predicted_sql_path)
    print(result)