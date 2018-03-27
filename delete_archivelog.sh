删除归档脚本
########################################################
#Author : Qi Lin
#DATE   : 2018/02/23 
########################################################
#!/bin/bash
DATE=`date +%Y%m%d%H`
source /home/oracle/.bash_profile
$ORACLE_HOME/bin/rman log=/u01/log/rman_${DATE}.log <<EOF
connect target/
run{
crosscheck archivelog all;
delete noprompt expired archivelog all;
delete noprompt archivelog all completed before 'sysdate-1'; 
}
exit;
EOF
exit


注意：在无法清除以前的归档日志的情况，可以先手工删除，然后在执行上面的shell脚本

3、定时任务，每小时执行一次
[oracle@rac1 ~]$ crontab -e
01 * * * * sh /u01/archivelog_delete.sh > /u01/log/delete_arch_log20 2>&1 &