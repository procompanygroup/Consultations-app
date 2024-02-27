import 'dart:io';

class AudioFile {
  //Instance variables
  int? serviceInputId;
  File? audioFile;


  //Constructor
  AudioFile(
      { this.serviceInputId, this.audioFile});
}
 class ImageFiles{
  int? serviceInputId;
  File? image1;
  File? image2;
  File? image3;
  File? image4;

  //Constructor
  ImageFiles(
      { this.serviceInputId, this.image1,this.image2,this.image3,this.image4});
 }