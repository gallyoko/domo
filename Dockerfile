# Telldus dans un container
#
# VERSION               0.0.1
#

FROM     fwed/zend-server:telldus
MAINTAINER Gallyoko "yogallyko@gmail.com"

# Mise a jour des depots
RUN (apt-get update && apt-get upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)

# Ajout du depot pour la cle TellStick
RUN echo 'deb http://download.telldus.com/debian/ stable main' | tee /etc/apt/sources.list.d/telldus.list
RUN wget -q http://download.telldus.com/debian/telldus-public.key -O- | apt-key add -
RUN apt-get update
RUN apt-get install -y -q telldus-core

# Ajout de la configuration de la cle TellStick 
RUN rm -f /etc/tellstick.conf
COPY tellstick.conf /etc/tellstick.conf
RUN chmod -f 664 /etc/tellstick.conf
RUN chown root:plugdev /etc/tellstick.conf

# script de lancement des services
RUN rm -f /root/services.sh
COPY services.sh /root/services.sh
RUN chmod -f 755 /root/services.sh
