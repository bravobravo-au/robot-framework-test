#!/bin/bash

docker run -it -v /Users/brad/robot-framework/test:/home/robot-framework -v /Users/brad/robot-framework/rf-logs:/home/robot-framework-logs --rm rf:latest /bin/bash
