#!/bin/python

import subprocess
from typing import Dict, Tuple


def is_recording() -> bool:
    result = subprocess.run(["pidof", "wf-recorder"], stdout=subprocess.PIPE)
    if result.returncode == 0:
        return True
    return False


def get_options() -> Dict[str, int]:
    options = {
        "Screenshot: a selected area": 1,  # M+1 to edit
        "Screenshot: a selected area copy": 2,  # M+1 to edit
        "Record: record selected area": 3,  # M+1 to record with mic
    }
    return options


def choose_options() -> Tuple[str, int]:
    result = subprocess.run(
        ["bemenu", "-i", "-l", "7", "-p", "Choose action? "],
        input="\n".join(get_options().keys()),
        encoding="ascii",
        stdout=subprocess.PIPE,
    )
    return result.stdout, result.returncode


def run():
    pass


if __name__ == "__main__":
    option, code = choose_options()
    print(option.strip(), code)
