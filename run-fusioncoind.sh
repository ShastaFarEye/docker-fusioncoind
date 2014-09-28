cd build 
make
cd ..
docker run -v /fusionblocks --name fusioncoin_blockdata phusion/baseimage  \
  echo fusioncoin blockdata 
docker run -d -p 44242:8492 -p 44243:18491 --name fusioncoind --volumes-from fusioncoin_blockdata \
  guruvan/fusioncoind /sbin/my_init
