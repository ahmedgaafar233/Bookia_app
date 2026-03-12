part of 'wishlist_cubit.dart';

abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

// Get Wishlist States
class GetWishlistLoading extends WishlistState {}
class GetWishlistSuccess extends WishlistState {}
class GetWishlistError extends WishlistState {}

// Add to Wishlist States
class AddToWishlistLoading extends WishlistState {}
class AddToWishlistSuccess extends WishlistState {}
class AddToWishlistError extends WishlistState {}

// Remove from Wishlist States
class RemoveFromWishlistLoading extends WishlistState {}
class RemoveFromWishlistSuccess extends WishlistState {}
class RemoveFromWishlistError extends WishlistState {}
