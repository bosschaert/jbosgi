if [ "$2" == "" ] 
then
    echo Please provide the jboss-as build location, and the location of the 
    echo jboss-as-osgi-launcher.jar file, e.g.
    echo  $0 /jboss-as/jboss-as-7.2.0 /jboss-as/osgi/launcher/target/jboss-as-osgi-launcher-7.2.0.jar
else
    if [ ! -d "$1/modules" ]
    then
        echo Please specify a valid jboss-as build directory.
        echo It must contain the modules subdirectory.
    else 

pushd `dirname $0`
CURDIR=`pwd`
popd

export TCKCHECKOUT=$CURDIR/r4v42tck
export JBOSS_AS_LOCATION=$1
export JBOSS_OSGI_LAUNCHER=$2

export JBOSS_AS_EMBEDDED=`find $JBOSS_AS_LOCATION | grep "\/jboss-as-embedded.*[.]jar$"`
export JBOSS_MODULES=`find $JBOSS_AS_LOCATION | grep "\/jboss-modules.*[.]jar$"`
export JBOSS_LOGGING=`find $JBOSS_AS_LOCATION | grep "\/jboss-logging.*[.]jar$"`
export JBOSS_AS_CONTROLLER_CLIENT=`find $JBOSS_AS_LOCATION | grep "\/jboss-as-controller-client.*[.]jar$"`
export JBOSS_LOGMANAGER=`find $JBOSS_AS_LOCATION | grep "\/jboss-logmanager.*[.]jar$"`
export JBOSS_DMR=`find $JBOSS_AS_LOCATION | grep "\/jboss-dmr.*[.]jar$"`
export JBOSS_MSC=`find $JBOSS_AS_LOCATION | grep "\/jboss-msc.*[.]jar$"`
export JBOSS_OSGI_CORE=`find $JBOSS_AS_LOCATION | grep "\/org[.]osgi[.]core.*[.]jar$"`

echo TCK Checkout directory: $TCKCHECKOUT
echo JBOSS_AS_LOCATION: $JBOSS_AS_LOCATION


# Clone the TCK repo 
if [ ! -d $TCKCHECKOUT ]; then
  svn co https://svn.devel.redhat.com/repos/jboss-tck/osgitck/r4v42 $TCKCHECKOUT
  #git clone /home/hudson/static_build_env/osgi-tck-4.2/r4v42 $TCKCHECKOUT
fi

# Switch to known tck-checkout tag 
# cd $TCKCHECKOUT; git checkout r4v42-core-cmpn-final

# Setup the TCK
ant setup.vi

# Run the core tests
ant run-core-tests
      
# Run the package admin tests
#ant run-packageadmin-tests

# Run the HTTP Service tests
#ant run-httpservice-tests

fi
fi
