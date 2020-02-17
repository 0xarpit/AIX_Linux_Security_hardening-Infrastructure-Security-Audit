#!/bin/sh


############################################
#AUDIT CHECKS FOR AIX
############################################



#------------------------------------------------------------------------------------------------------------------------------
# AIX_Security_Audit_Checks (Defect Retest)
#
#------------------------------------------------------------------------------------------------------------------------------
# Expected output: System Checks Completed
#------------------------------------------------------------------------------------------------------------------------------
# GUIDE
#------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------
# HOW TO USE
#------------------------------------------------------------------------------------------------------------------------------
#
# The script should be executed as root with bash.
# eg:
#   AIX_Audit.sh
#
#
# A series of checks are executed
# No modifications are performed
#
# Running this script should produce no result except the phrase
# "System Checks Completed".
# If there is any other output, then one or more warnings have been issued
#
# There will be an archive created once the script completes.

echo "As part of APT 2018 - this HBA script will perform certain checks on this system"
echo "No changes will be made to system"
echo ""
echo ""
echo "Initializing script";
echo ""
sleep 5
echo ".........."


#For list of Software versions installed :
echo ' #################################################################software versions#################################################################' >> Auditcheck.txt
lslpp -h >> Auditcheck.txt
echo '####################################################################################################################################################' >> Auditcheck.txt
lslpp -h all >> Auditcheck.txt
echo '##################################################################List of packages#################################################################' >> Auditcheck.txt
lslpp -l -a >> Auditcheck.txt
echo '####################################################################################################################################################' >> Auditcheck.txt
lslpp -L all >> Auditcheck.txt
echo '####################################################################################################################################################' >> Auditcheck.txt
lslpp -l all >> Auditcheck.txt
echo '####################################################################################################################################################' >> Auditcheck.txt
#OS Level
echo '############################################# Current version of OS #################################################################' >> Auditcheck.txt
oslevel -s >> Auditcheck.txt
echo '############################################# Current security patches installed #################################################################' >> Auditcheck.txt
/usr/sbin/instfix -i >> Auditcheck.txt
echo '####################################################################################################################################################' >> Auditcheck.txt
#SETUID programs
echo '#################################################################SETUID permissions#################################################################' >> Auditcheck.txt
find / -perm -1000 -print >> Auditcheck.txt
echo '#################################################################SETGID permissions#################################################################' >> Auditcheck.txt
find / -perm -2000 -print >> Auditcheck.txt
echo '####################################################################################################################################################' >> Auditcheck.txt
#Passwords
echo '#################################################################weak password inconsistencies check#################################################################' >> Auditcheck.txt
cat /etc/security/passwd >> Auditcheck.txt
echo ' #########################################Weak Hashing alogorithm Hashing check congif file ############################################' >> Auditcheck.txt
cat /etc/security/login.cfg >> Auditcheck.txt
echo '################################################invalid password field####################################################################################################' >> Auditcheck.txt
pwdck -n ALL >> Auditcheck.txt
echo '###############################################################Account Expiry CHECKS#####################################################################################' >> Auditcheck.txt
usrck -n ALL >> Auditcheck.txt
echo '####################################################################################################################################################' >> Auditcheck.txt
#For SSH config check :
echo '#################################################################SSH configuration#################################################################' >> Auditcheck.txt
cat /etc/ssh/sshd_config >> Auditcheck.txt
# For network Paramaters check :
echo '#################################################################network paramaters check Nextboot#################################################################' >> Auditcheck.txt
cat /etc/tunables/nextboot >> Auditcheck.txt
echo '################################################################# network paramaters check #################################################################' >> Auditcheck.txt
no -a >> Auditcheck.txt
echo '####################################################################################################################################################' >> Auditcheck.txt
# for User account and Enviorment settings :
echo '################################################################# User account and enviorment checks #################################################################' >> Auditcheck.txt
cat /etc/security/user >> Auditcheck.txt
echo '################################################################# Limits config file #################################################################' >> Auditcheck.txt
cat /etc/security/limits >> Auditcheck.txt
echo '################################################################# Services ################################################################# ' >> Auditcheck.txt
cat /etc/inetd.conf >> Auditcheck.txt
echo '#############################################################################################################################################' >> Auditcheck.txt
grep -v "^#" /etc/inetd.conf |grep rshd >> Auditcheck.txt
grep -v "^#" /etc/inetd.conf |grep rlogin >> Auditcheck.txt
grep -v "^#" /etc/inetd.conf |grep rsh >> Auditcheck.txt
grep -v "^#" /etc/inetd.conf |grep rlogind >> Auditcheck.txt
grep -v "^#" /etc/inetd.conf |grep dayime >> Auditcheck.txt
grep -v "^#" /etc/inetd.conf |grep time >> Auditcheck.txt
grep -v "^#" /etc/inetd.conf |grep ntalk >> Auditcheck.txt
grep -v "^#" /etc/inetd.conf |grep qdaemon >> Auditcheck.txt
grep -v "^#" /etc/inetd.conf |grep lpd >> Auditcheck.txt
grep -v "^#" /etc/inetd.conf |grep piobe >> Auditcheck.txt
grep -v "^#" /etc/inetd.conf |grep tftpd >> Auditcheck.txt

echo '#################################################################File permisissions#################################################################' >> Auditcheck.txt
ls -lL /etc /bin /usr/bin /usr/lbin /usr/ucb /sbin /usr/sbin /pacotes/gateways/install/*  /OS_Backups  /OS_Backups/AIX61TL09SP06_Patch_Prep /opt/dbtools/sshmgr/backups/sshd_config/* >> Auditcheck.txt &> /dev/null;
echo '#################################################################Should be owned by a system group#################################################################' >> Auditcheck.txt
ls -lLa /etc /bin /usr/bin /usr/lbin /usr/ucb /sbin /usr/sbin >> Auditcheck.txt &> /dev/null;

#-------------------------------------------------------------------------------------------------------------
# Creating Archive
gzip Sec_Results Auditcheck.txt &> /dev/null;
sleep 5
#--------------------------------------------------------------------------------------------------------------
# DONE
#--------------------------------------------------------------------------------------------------------------

echo "System Checks Completed"
