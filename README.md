# transfusion-reactions

# Set Up Instructions
1. Connect to MIMIC as described in PSET 2 :)
2. Click the funny little "Activate Cloud Shell" button in the top right, then open it in a new pane
3. Click the Open Editor button and voila you're in a mini fake vs code environment
4. Oh dang ig we don't have our extensions . . . install gitlens, Jupyter, and your other usual toppings (it comes with python)
5. You should probably log in to your github on command line and clone this repo
    - `git config --global user.name "your_username"`
    - `git config --global user.email "your_email_address@example.com"`
    - `git config --global --list` to check configs
    - `git clone <the url of this repo>`
6. ~~Time to install conda (I know I know, pyenv-venv is better, but Kateryna likes Conda)~~ Update: she let us use pyenv-virtualenv -- thanks Kat
    - install pyenv virtualenv (see [this page](https://github.com/pyenv/pyenv-virtualenv) for more information)
        - `git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv`
        - `echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc`
        - `exec "$SHELL"` (restart shell)
    - install pyenv (see [this page](https://github.com/pyenv/pyenv) for more instructions)
        - `curl https://pyenv.run | bash`
        - `export PYENV_ROOT="$HOME/.pyenv"`
        - `[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"`
        - `eval "$(pyenv init -)"`
        - `eval "$(pyenv virtualenv-init -)"`
    - install python 3.12: `pyenv install 3.12`
    - make a virtual environment `pyenv virtualenv 3.12 transfusion`
    - make a .python-version file and put the name of the environment (here "transfusion")
7.  Be happy for a minute because pyenv virtualenv is all working smoothly, there weren't any errors, and life is good :) -- see Kat, it is better
8. If the kernel doesn't show up, reload the page :o
9. Install the required libraries: `pip install -r requirements.txt`
10. Create an file called `.env`, and populate it with the following values:
    - `BIGQUERY_PROJECT_NAME="your-project-name"`
    - `BASE_QUERY_PATH="filepath_to_queries_folder"`

## Alternate setup instructions with GCloud CLI and a remote tunnel from VS Code

1. Install the (GCloud cli)[https://cloud.google.com/sdk/docs/install-sdk]
2. Follow (these instructions)[https://cloud.google.com/workstations/docs/develop-code-using-local-vscode-editor#extension-marketplace] to open a cloud workstation. You may need to enable the API. Expect to wait ~20 mins for the workspace configurations to get created.
   1. Under Machine Settings > advanced options, uncheck the "disable SSH" option
   2. Under Machine Settings > cost savings, set the timeouts to 1 hour and 6 hours to save costs
   3. These were Kat's settings for the gcloud start-tcp-tunnel command
    ```
    gcloud workstations start-tcp-tunnel \
        --project=transfusion-reactions \
        --region=northamerica-northeast1 \
        --cluster=transfusion-reaction-cluster  \
        --config=transfusion-reaction-workstation  \
        transfusion-reaction-workstation 22
    ```
   4. When you're connecting to the remote-ssh server in VS Code, be sure to add user@localhost:XXXXXXXXXXXXXX to your configurations, so that you can connect to it more easily in the future.
3. If the workstation goes down, go to the workstation tab in GCP online and activate the workstation
4. In theory you can set up the environment from above in the workstation, but I can't get it to work, so Kat gives up :(

