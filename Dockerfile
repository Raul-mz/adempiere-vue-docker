FROM nginx:alpine

LABEL maintainer="EdwinBetanc0urt@outlook.com" \
	description="ADempiere-Vue"

ARG RELEASE_VERSION="rt-2.7"

ENV URL_REPO="https://github.com/adempiere/adempiere-vue" \
	BINARY_NAME="Adempiere-Vue.zip" \
	SERVER_HOST="localhost" \
	SERVER_PORT="9527" \
	API_HOST="localhost" \
	API_PORT="8085" 


COPY Start.sh .

# Create app directory
RUN cd /usr/share/nginx/html && \
	cd /opt/Apps && \
	# Install needed SO packages
	apk add --no-cache \
		ca-certificates \
		curl \
		unzip && \
	# Download release file
	curl --output $BINARY_NAME \
                -L "$URL_REPO/releases/download/$RELEASE_VERSION/$BINARY_NAME" && \
	# uncompress and delete files
	unzip -o $BINARY_NAME && \
	rm $BINARY_NAME && \
	# Rename project folder
	dist/* /usr/share/nginx/html/
	# Change workdir
	cd /opt/Apps/adempiere-vue
	
WORKDIR /usr/share/nginx/html/

CMD sh Start.sh
