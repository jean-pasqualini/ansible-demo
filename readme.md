##### Deploy
1. make install-python
2. source ~/.venvs/ansible/bin/activate
3. make install-ansible VENV=1
4. make get-ansible-vendor
5. create a file .vault_pass.txt with the vault password
6. change the file ansible/hosts.ini to update the ips according to the ones where you deploy
7. make provisioning APP_NAME=(app-knp|app-symfony)
7. make deploy SYMFONY_ENV=(prod|dev|test) APP_NAME=(app-knp|app-symfony)