FROM node:lts

RUN apt-get update \
&& apt-get install wget gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget --yes --fix-missing --no-install-recommends\
&& wget --no-check-certificate https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
&& dpkg -i google-chrome-stable_current_amd64.deb || apt -y -f install \
&& rm google-chrome-stable_current_amd64.deb \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
&& apt autoremove --yes

EXPOSE 8080

#
# Clone repo and prepare working directory
#
RUN git clone -b master https://github.com/patricklightsec/botwat-v1 /home/botwat-v1
WORKDIR /home/

RUN npm install
RUN npm install --only=dev --ignore-scripts

CMD ["npm", "start"]
