FROM greatexpectations/great_expectations:python-3.7-buster-ge-0.12.0

RUN apt-get update && apt-get install curl nodejs -y
RUN curl -L https://npmjs.org/install.sh | bash
RUN npm install -g netlify-cli
ENV NODE_PATH="/usr/lib/node_modules"

COPY run_checkpoints.sh /run_checkpoints.sh
COPY build_gh_action_site.py /build_gh_action_site.py
RUN chmod u+x /run_checkpoints.sh

# Ensure that additional requirements such as xlrd are installed (not in default GE-image)
COPY requirements.txt /requirements.txt
RUN pip install -r requirements.txt

ENTRYPOINT ["/bin/bash", "/run_checkpoints.sh"]
