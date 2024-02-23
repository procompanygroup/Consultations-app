part of 'service_images_cubit.dart';

@immutable
abstract class ServiceImagesState {
  File? get image1 => null;
  File? get image2 => null;
  File? get image3 => null;
  File? get image4 => null;

}


class ServiceImagesInitial extends ServiceImagesState {}

class ServiceImagesLoading extends ServiceImagesState {
  @override

  late final File? image1;
  late final File? image2;
  late final File? image3;
  late final File? image4;
  ServiceImagesLoading(this.image1,this.image2,this.image3,this.image4);

  get firstImage => image1;
  get secondImage => image2;
  get thirdImage => image3;
  get fourthImage => image4;
}
class ServiceImagesFailure extends ServiceImagesState {}
