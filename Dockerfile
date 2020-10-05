FROM ubuntu:20.04
ENV TZ=Australia/Melbourne
ENV GECKODRIVER_VERSION 0.27.0
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    echo keyboard-configuration keyboard-configuration/layout select 'English (US)' | debconf-set-selections && \
    echo keyboard-configuration keyboard-configuration/layoutcode select 'us' | debconf-set-selections && \
    echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections && \
    		apt-get update && \ 
		apt-get install -y \
		python3-pip \
		xvfb \
		firefox \
		firefox-locale-en \
		wget \
		phantomjs && \
		pip3 install robotframework && \
		pip3 install robotframework-selenium2library && \
        	pip3 install robotframework-selenium2screenshots && \
		pip3 install robotframework-httplibrary && \
		pip3 install -U selenium && \
		cd /home && \
		wget --no-verbose -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v$GECKODRIVER_VERSION/geckodriver-v$GECKODRIVER_VERSION-linux64.tar.gz \
  		&& rm -rf /opt/geckodriver \
  		&& tar -C /opt -zxf /tmp/geckodriver.tar.gz \
  		&& rm /tmp/geckodriver.tar.gz \
  		&& mv /opt/geckodriver /opt/geckodriver-$GECKODRIVER_VERSION \
  		&& chmod 755 /opt/geckodriver-$GECKODRIVER_VERSION \
  		&& ln -fs /opt/geckodriver-$GECKODRIVER_VERSION /usr/bin/geckodriver \
  		&& ln -fs /opt/geckodriver-$GECKODRIVER_VERSION /usr/bin/wires
ENV RFLOGS=/home/robot-framework-logs

RUN mkdir /home/robot-framework && \
	mkdir $RFLOGS


COPY entry-point.sh /home/entry-point.sh
RUN chmod a+rx /home/entry-point.sh

ENTRYPOINT ["/home/entry-point.sh"]		 
