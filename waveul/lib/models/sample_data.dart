import 'package:flutter/material.dart';
import 'package:waveul/models/song.dart';
import 'package:waveul/models/playlist.dart';
import 'package:waveul/models/genre.dart';

class SampleData {
  // Canciones populares del momento
  static List<Song> get popularSongs => [
    Song(
      id: 5,
      title: "Heat Waves",
      artist: "Glass Animals",
      localImage: "assets/images/heat_waves.jpg",
      duration: 238, // 3:58
      rating: 4.7,
      playCount: 1250000,
      // releaseDate: DateTime(2020, 6, 29), // TEMPORAL: comentado para test
    ),
    Song(
      id: 6,
      title: "Bad Habits",
      artist: "Ed Sheeran",
      localImage: "assets/images/Bad_Habits.png",
      duration: 231, // 3:51
      rating: 4.3,
      playCount: 890000,
      // releaseDate: DateTime(2021, 6, 25), // TEMPORAL: comentado para test
    ),
    Song(
      id: 7,
      title: "Industry Baby",
      artist: "Lil Nas X ft. Jack Harlow",
      localImage: "assets/images/industry_baby.png",
      duration: 212, // 3:32
      rating: 4.6,
      playCount: 750000,
      // releaseDate: DateTime(2021, 7, 23), // TEMPORAL: comentado para test
    ),
    Song(
      id: 8,
      title: "I wonder",
      artist: "Kanye West",
      localImage: "assets/images/i_wonder.png",
      duration: 198, // 3:18
      rating: 4.1,
      playCount: 950000,
      // releaseDate: DateTime(2021, 3, 19), // TEMPORAL: comentado para test
    ),
  ];

  // Playlists de ejemplo
  static List<Playlist> get samplePlaylists => [
    Playlist(
      id: 1,
      name: "Chill Songs",
      songCount: 29,
      totalDuration: 4800, // 1h 20m
      description: "Para relajarse y descansar",
      localImage: "assets/images/chill_playlist.jpg",
      createdBy: "Usuario",
      saveIn: 1250, // Cambiado de saveCount a saveIn para coincidir con ERD
    ),
    Playlist(
      id: 2,
      name: "Workout Mix",
      songCount: 15,
      totalDuration: 2700, // 45m
      description: "Energía para entrenar",
      localImage: "assets/images/workout_playlist.png",
      createdBy: "FitMusic",
      saveIn: 890, // Cambiado de saveCount a saveIn para coincidir con ERD
    ),
    Playlist(
      id: 3,
      name: "Road Trip Vibes",
      songCount: 42,
      totalDuration: 7200, // 2h
      description: "Perfecta para viajes largos",
      localImage: "assets/images/road_trip_playlist.png",
      createdBy: "TravelTunes",
      saveIn: 2100, // Cambiado de saveCount a saveIn para coincidir con ERD
    ),
  ];

  // Géneros para explorar
  static List<Genre> get exploreGenres => [
    Genre(
      id: 1,
      name: "Reggaetón",
      gradientColors: const [Color(0xFFE8C765), Color(0xFF826F38)], // Dorado actualizado con tus colores
      localImage: "assets/images/kanye.png", // Usamos imagen existente
      description: "Ritmos urbanos latinos",
      songCount: 120,
    ),
    Genre(
      id: 2,
      name: "Rock",
      gradientColors: const [Color(0xFFE86565), Color(0xFF823838)], // Rojo actualizado con tus colores
      localImage: "assets/images/Bad_Habits.png", // Usamos imagen existente
      description: "Rock clásico y alternativo",
      songCount: 95,
    ),
    Genre(
      id: 3,
      name: "Pop",
      gradientColors: const [Color(0xFFE865E1), Color(0xFF82387E)], // Rosado actualizado con tus colores
      localImage: "assets/images/billie.png", // Usamos imagen existente
      description: "Éxitos populares actuales",
      songCount: 150,
    ),
    Genre(
      id: 4,
      name: "Electrónica",
      gradientColors: const [Color(0xFF6CB255), Color(0xFF2E4C24)], // Verde actualizado con tus colores
      localImage: "assets/images/industry_baby.png", // Usamos imagen existente
      description: "Música electrónica y EDM",
      songCount: 80,
    ),
  ];
}