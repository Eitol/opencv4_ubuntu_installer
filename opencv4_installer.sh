#!/usr/bin/env bash

BUILD_FOR_JAVA=ON
BUILD_FOR_PYTHON=OFF
OPENCV_VERSION=4.1.0
ANT_HOME=/usr/share/ant
# OFF = JAR includes all the OpenCV code inside (recommended for docker)
# ON  = JAR depends of external system libs
BUILD_SHARED_LIBS=OFF

### MISC ##
INSTALLER_DIR=./installers
TMP_DIR=/tmp/opencv
BIN_INSTALL_DIR=/usr/local


sudo apt -y install apt-transport-https ca-certificates curl software-properties-common
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu cosmic stable"
sudo apt -y install docker-ce
OPENCV_VERSION=master
BIN_INSTALL_DIR=/usr/local

sudo apt -y install pkg-config yasm curl wget libjpeg8-dev libtiff-dev  libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libxine2-dev libv4l-dev software-properties-common  libgstreamer1.0-dev  libgstreamer-plugins-base1.0-dev libgtk2.0-dev libtbb-dev qt5-default libatlas-base-dev libfaac-dev libmp3lame-dev libtheora-dev libvorbis-dev libxvidcore-dev libopencore-amrnb-dev libopencore-amrwb-dev libavresample-dev x264 v4l-utils libgphoto2-dev libeigen3-dev libhdf5-dev doxygen git gfortran build-essential checkinstall cmake libgstreamer1.0-dev ant-contrib libv4l-dev libx264-dev openexr openssl libssl-dev

if [ $? != 0 ]; then
    echo "ERROR: Check the instalation, fix then and rerun the installer"
fi


sudo apt -y install libgstreamer-plugins-base1.0-dev lvtk-dev ant java-wrappers libblas-dev liblapack-dev libeigen3-dev libavcodec-dev libavcodec-extra libavformat-dev libavutil-dev libswscale-dev libswscale-dev libgstreamer1.0-dev ffmpeg ccache libopenblas-dev libtiff5-dev pylint flake8 libcaffe-cuda-dev  libprotobuf-dev libogre-1.9-dev libvtk7-qt-dev libtesseract-dev libatlas-base-dev libatlas-cpp-0.6-dev libhdf5-dev libhdf5-dev libjhdf5-java libleptonica-dev libgtkmm-3.0-dev libgtk-3-dev libjpeg-dev liblapacke-dev libprotobuf-c-dev

if [ $? != 0 ]; then
    echo "ERROR: Check the instalation, fix then and rerun the installer"
fi

sudo ln -s /usr/include/lapacke.h /usr/include/x86_64-linux-gnu
sudo ln -s /usr/bin/vtk7 /usr/bin/vtk

sudo apt -y install libatlas-base-dev libfaac-dev libmp3lame-dev libtheora-dev libvorbis-dev libxvidcore-dev libopencore-amrnb-dev libopencore-amrwb-dev libavresample-dev x264 v4l-utils libprotobuf-dev protobuf-compiler libgoogle-glog-dev libgflags-dev libprotobuf-dev protobuf-compiler libgtk2.0-dev libtbb-dev qt5-default python3-testresources python3-dev python3-pip

if [ $? != 0 ]; then
    echo "ERROR: Check the instalation, fix then and rerun the installer"
fi

wget http://security.ubuntu.com/ubuntu/pool/main/j/jasper/libjasper1_1.900.1-debian1-2.4ubuntu1.2_amd64.deb
wget http://security.ubuntu.com/ubuntu/pool/main/j/jasper/libjasper-dev_1.900.1-debian1-2.4ubuntu1.2_amd64.deb

sudo apt -y install ./libjasper1_1.900.1-debian1-2.4ubuntu1.2_amd64.deb
sudo apt -y install ./libjasper-dev_1.900.1-debian1-2.4ubuntu1.2_amd64.deb


sudo apt -y install python python3 python3-dev python3-pip python-pip python-dev
sudo pip3 install pip numpy scipy matplotlib scikit-image scikit-learn ipython dlib
sudo pip install pip numpy scipy matplotlib scikit-image scikit-learn ipython dlib



if [ ! -f ${INSTALLER_DIR}/opencv.zip ]; then
    echo "Downloading the installers in ${INSTALLER_DIR} folder"
    curl -L -o ${INSTALLER_DIR}/opencv.zip https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip
    curl -L -o ${INSTALLER_DIR}/opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip
else
    echo "Taking the ./installers folder files"
fi

if [ ! -d ${TMP_DIR} ]; then
    mkdir -p ${TMP_DIR}
    unzip ${INSTALLER_DIR}/opencv.zip -d ${TMP_DIR}
    unzip ${INSTALLER_DIR}/opencv_contrib.zip -d ${TMP_DIR}
fi

mkdir -p ${TMP_DIR}/opencv-${OPENCV_VERSION}/build
cd ${TMP_DIR}/opencv-${OPENCV_VERSION}/build
export ANT_HOME=${ANT_HOME}
cmake -DCMAKE_BUILD_TYPE=RELEASE \
 -DCMAKE_INSTALL_PREFIX=${BIN_INSTALL_DIR} \
 -DOPENCV_EXTRA_MODULES_PATH=${TMP_DIR}/opencv_contrib-${OPENCV_VERSION}/modules \
 -DBUILD_DOCS=OFF \
 -DBUILD_EXAMPLES=OFF \
 -DBUILD_TESTS=OFF \
 -DBUILD_PERF_TESTS=OFF \
 -DOPENCV_ENABLE_NONFREE=ON \
 -DBUILD_opencv_java=${BUILD_FOR_JAVA} \
 -DBUILD_opencv_python=${BUILD_FOR_PYTHON} \
 -DBUILD_opencv_python2=${BUILD_FOR_PYTHON} \
 -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS} \
 -DBUILD_opencv_python3=${BUILD_FOR_PYTHON} ..

make -j$(nproc)

if [ ! -w ${BIN_INSTALL_DIR} ]; then
    echo "this script needs special permissions"
    echo "Please enter the sudo password"
    sudo make install
else
    make install
fi


echo "Installation finished"
echo "The jar: 'opencv-410.jar' is saved in ls /usr/local/share/java/opencv4"
echo "The so: libopencv_java410.so is saved in /usr/local/share/java/opencv4/"
