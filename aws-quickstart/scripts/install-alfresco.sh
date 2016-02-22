 #!/bin/bash

# This script will install chef-alfresco into your box, fetching all
# artifacts needed from remote locations
#
# An example of how to use it in a Cloudformation template:
#
# Allowed values
#NODE_NAME=share
#NODE_NAME=solr

if [ -z "$CHEF_ALFRESCO_VERSION" ]; then
  CHEF_ALFRESCO_VERSION="0.6.22"
fi

if [ -z "$COOKBOOKS_TARBALL_URL" ]; then
  #COOKBOOKS_TARBALL_URL=https://artifacts.alfresco.com/nexus/service/local/repositories/releases/content/org/alfresco/devops/chef-alfresco/$CHEF_ALFRESCO_VERSION/chef-alfresco-$CHEF_ALFRESCO_VERSION.tar.gz
  # temporary fix to get always snapshot version
  COOKBOOKS_TARBALL_URL=https://s3.amazonaws.com/quickstart-reference/alfresco-one/latest/scripts/chef-alfresco.tar.gz
fi

# Install Chef - latest version
curl https://www.opscode.com/chef/install.sh | bash

# Download chef-alfresco tar.gz into /tmp folder
curl -L $COOKBOOKS_TARBALL_URL > /tmp/cookbooks.tar.gz

# Unpack it in /tmp
rm -rf /etc/chef/cookbooks
tar xvzf /tmp/cookbooks.tar.gz -C /etc/chef

if [ -n "$DATABAGS_TARBALL_URL" ]; then
  curl -L $DATABAGS_TARBALL_URL > /tmp/databags.tar.gz
  rm -rf /etc/chef/data_bags
  tar xvzf /tmp/databags.tar.gz -C /etc/chef
fi
