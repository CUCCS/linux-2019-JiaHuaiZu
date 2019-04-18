#!/bin/bash
#Image processing

function usage()
{
echo " IMproved 1.0 (2019 April 12) "
echo " usage: bash image processing "
echo " Arguments: "
echo " -p [length compression percent] [height compression percent] [source image] [destination image]: Compression resolution ratio while keeping original aspect ratio for jpeg/png/svg "
echo " -q [quality(0-100)] [source image] [destination image]:Compression of picture(jpeg) quality "
echo " -m [position] [text] [source image]|[source image folder]:Add custom text watermarking to image or all of images in folder "
echo " -r [position] [text]:Batch addition of prefixes or suffixes "
echo " -t :convert all png/svg to jpg"
}

function Process()
{
	if [ "$1" == "-p" ];then
		if [ $# == 5 ];then
			$(convert -resize $2%X$3% $4 $5)
			exit 1
		else 
			usage
		fi
	elif [ "$1" == "-q" ];then
		if [ $# == 4 ];then
			$(convert -quality $2 $3 $4)
			exit 1
		else
			usage
		fi
	elif [ "$1" == "-m" ];then
		if [ $# == 4 ];then
			if [ `file --mime-type -b $4` == "inode/directory" ];then
				for img in $4/*
                                do
					if [ `file --mime-type -b $img` == "image/jpeg" ];then
                               		$(convert $img -gravity $2 -draw "text 5,5 '$3'" $img)
					fi
                                done
	                        exit 1
			else
				$(convert $4 -gravity $2 -draw "text 5,5 '$3'" $4)
				exit 1
			fi
		else
			usage
		fi
	elif [ "$1" == "-r" ];then
		if [ $# == 3 ];then
			if [ "$2" == "front" ];then
				$(rename 's/^/$3/' *)
				exit 1
			elif [ "$2" == "behind" ];then
				$(rename 's/\./'$3'\./' *)
				exit 1
			else
				usage
			fi
		fi
	elif [ "$1" == "-t" ];then
		for f in *
		do
			if [[ $f =~ '.png' ]];then
				str=$f
				str=${str/\.png/\.jpg}
				$(convert $f $str) 
			else [[ $f =~ '.svg' ]]
				str0=$f
				str0=${str0/\.svg/\.jpg}
				$(convert $f $str)	
			fi
		done
		exit 1
	fi	

}
Process $1 $2 $3 $4 $5
