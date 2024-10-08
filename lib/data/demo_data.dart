// lib/data/demo_data.dart
import 'dart:ui';
// lib/data/demo_data.dart
import 'package:flutter/material.dart';
import 'package:laptopharbor/models/Product.dart';

List<Product> demoProducts = [
  Product(
    id: "1",
    title: "PREDATOR HELIOS 300",
    brandName: "Acer",
    images: [
      "assets/images/predator/predator1.png",
      "assets/images/predator/predator2.png",
      "assets/images/predator/predator3.png",
    ],
    price: 1749.99,
    description: "High-performance gaming laptop with advanced cooling.",
    rating: 4.8,
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    isFavourite: false,
    isPopular: true,
  ),
  Product(
    id: "2",
    images: [
      "assets/images/msi/msi1.jpg",
      "assets/images/msi/msi2.jpg",
      "assets/images/msi/msi3.jpg",
      "assets/images/msi/msi4.jpg",
      "assets/images/msi/msi5.jpg",
      "assets/images/msi/msi6.jpg",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    brandName: "MSI",
    title: "MSI Raider GE76",
    price: 1108.79,
    description: "Powerful gaming laptop with RTX 3080.",
    rating: 4.9,
    isFavourite: false,

    isPopular: true,
  ),
  Product(
    id:" 3",
    images: [
      "assets/images/rog/rog1.webp",
      "assets/images/rog/rog2.webp",
      "assets/images/rog/rog3.webp",
      "assets/images/rog/rog4.webp",
    ],
    colors: [
      const Color(0xFFF6625E),
      const Color(0xFF836DB8),
      const Color(0xFFDECB9C),
      Colors.white,
    ],
    brandName: "Asus",
    title: "ROG FLOW Z13-ACRNM RMTO2",
    price: 2199.99,
    description: "The ROG Flow Z13-ACRNM RMTO2 is a high-performance gaming tablet from ASUS's Republic of Gamers (ROG) series",
    rating: 4.1,
    isFavourite: false,
    isPopular: true,
  ),
  Product(
    id: "4",
    images: [
      "assets/images/mac/mac1.jpg",
      "assets/images/mac/mac2.jpg",
      "assets/images/mac/mac3.jpg",
      "assets/images/mac/mac4.jpg",
    ],
    colors: [
      const Color(0xFF000000),
      const Color(0xFFFFFFFF),
      const Color(0xFF2C2C2C),
      Colors.grey,
    ],
    brandName: "Apple",
    title: "MacBook Pro 16",
    price: 2399.99,
    description: "High-performance laptop with M1 Pro chip.",
    rating: 4.7,
    isFavourite: false,
    isPopular: true,
  ),
  Product(
    id: "5",
    images: [
      "assets/images/m/m1.jpg",
      "assets/images/m/m2.jpg",
      "assets/images/m/m3.jpg",
      "assets/images/m/m4.jpg",
    ],
    colors: [
      const Color(0xFF000000),
      const Color(0xFFFFFFFF),
      Colors.grey,
    ],
    brandName: "Apple",
    title: "MacBook Air M2",
    price: 1249.99,
    description: "Lightweight laptop with M2 chip.",
    rating: 4.5,
    isPopular: true,
  ),
  Product(
    id:" 6",
    images: [
      "assets/images/pixel/pixel1.jpg",
      "assets/images/pixel/pixel2.jpg",
      "assets/images/pixel/pixel3.jpg",
      "assets/images/pixel/pixel4.jpg",
      "assets/images/pixel/pixel5.jpg",
      "assets/images/pixel/pixel6.jpg",
      "assets/images/pixel/pixel7.jpg",
      "assets/images/pixel/pixel8.jpg",
      "assets/images/pixel/pixel9.jpg",
    ],
    colors: [
      const Color(0xFF4285F4),
      const Color(0xFFF4B400),
      const Color(0xFF0F9D58),
      Colors.white,
    ],
    brandName: "Google",
    title: "Google Pixelbook Go",
    price: 849.99,
    description: "Fast, portable Chromebook with long battery life.",
    rating: 4.6,
    isFavourite: false,
    isPopular: true,
  ),
  Product(
    id: "7",
    images: [
      "assets/images/lenovo/lenovo1.jpg",
      "assets/images/lenovo/lenovo2.jpg",
      "assets/images/lenovo/lenovo3.jpg",
      "assets/images/lenovo/lenovo4.jpg",
      "assets/images/lenovo/lenovo5.jpg",
    ],
    colors: [
      const Color(0xFF4285F4),
      const Color(0xFFF4B400),
      const Color(0xFF0F9D58),
      Colors.white,
    ],
    brandName: "Lenovo",
    title: "Lenovo Chromebook Duet",
    price: 299.99,
    description: "2-in-1 Chromebook with detachable keyboard.",
    rating: 4.3,
    isFavourite: false,

    isPopular: true,
  ),
  Product(
    id: "8",
    images: [
      "assets/images/alienware/alienware1.webp",
      "assets/images/alienware/alienware2.webp",
      "assets/images/alienware/alienware3.webp",
      "assets/images/alienware/alienware4.webp",
      "assets/images/alienware/alienware5.webp",
      "assets/images/alienware/alienware6.webp",
      "assets/images/alienware/alienware7.webp",
      "assets/images/alienware/alienware8.webp",
      "assets/images/alienware/alienware9.webp",
    ],
    colors: [
      const Color(0xFF1C1C1C),
      const Color(0xFF2D2D2D),
      const Color(0xFF3E3E3E),
      Colors.white,
    ],
    brandName: "Dell",
    title: "Alienware m15 R6",
    price: 2299.99,
    description: "High-end gaming laptop with NVIDIA GeForce RTX 3080.",
    rating: 4.9,
    isFavourite: false,
    isPopular: true,
  ),
];
