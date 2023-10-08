# fusionpbxwilcardautomation
It automates LetsEncrypt WildCard Certification Emission for FusionPBX

![image](https://github.com/inoutglobal/fusionpbxwilcardautomation/assets/47820627/91823d63-17d3-42ac-bdb9-28cb5a48f9c5)

![image](https://github.com/inoutglobal/fusionpbxwilcardautomation/assets/47820627/3b944639-a2c0-4b42-a762-81f072b04801)



The LetsEncrypt SSL certification process requires a challenge step between LetsEncrypt and the wildcard domain's DNS to be propperly validated.

Environment and requirements:

FusionPBX 5.1

PowerDNS 4.2 with API activated, access key, firewall enabled for port 8081.

Install curl and jq applications >> apt install curl jq

https://doc.powerdns.com/authoritative/http-api/index.html



1-SSL and TLS certificates are necessary for two applications, NGINX and Freeswitch. Wildcard certificate valid for one year can cost an average of US200!

2-Nginx performs SSL encryption of the FusionPBX FrontEnd environment and Fresswitch uses SIP signaling, media RTP (SRTP) and even WebRTC for encryption where it is mandatory.

3- Fusion has a script that issues LetsEncrypt SSL and TLS certificates for wildcard domains. However, it is a manual process where an interaction with the Name Server DNS must occur, introducing a TXT entry with a predetermined value in the challenge process. The process must be carried out manually every 3 months. The management of this is not that good.

4-This procedure takes into account that PowerDNS is used with Fusion domain name resolution DNS. But it can be used for other solutions that provide an API. Just adapt the script to the environment.

STEPS:

A. Customize letsencrypt.sh in the /usr/src/fusionpbx-install.sh/debian/resources directory

B. Customize Hook hook.sh in the /etc/dehydrated directory

C. Run the script manually to check if the process is occurring correctly and automatically.

./letsencrypt.sh

D.Create symbolic link in /etc/cron.monthly/

This step is important so that the script runs monthly.

cd /etc/cron.monthly

ln -s /usr/src/fusionpbx-install.sh/debian/resources/letsencrypt.sh letsencrypt


