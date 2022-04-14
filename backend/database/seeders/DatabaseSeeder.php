<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Faker\Factory as Faker;
use App\Models\User;
use App\Models\Review;
use App\Models\Komentar;
use App\Models\Tikum;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // \App\Models\User::factory(10)->create();
        $faker = Faker::create('id_ID');


        // Seeding User
        echo "Seeding User\n";
        $userTemporary = [];
        for ($i = 0; $i < 30; $i += 1) {
            $user = User::create([
                'name' => $faker->name(),
                // Soal COTS
                "username" => $faker->userName(),
                //
                'email' => $faker->email(),
                'password' => Hash::make($faker->password())
            ]);
            array_push($userTemporary, $user);
        }

        // Review
        echo "Seeding Review\n";
        $reviewTemporary = [];
        for ($i = 0; $i < 30; $i += 1) {
            $review = Review::create([
                'nama_tempat' => $faker->sentence(2),
                'alamat' => $faker->sentence(10),
                'rating' => $faker->randomFloat(1, 0, 5),
                'review' => $faker->paragraph(10),
                'latitude' => $faker->randomFloat(1, -90, 90),
                'longitude' => $faker->randomFloat(1, -90, 90),
                'photo' => "https://source.unsplash.com/random",
                'user_id' => $userTemporary[array_rand($userTemporary)]->id
            ]);
            array_push($reviewTemporary, $review);
        }

        // Komentar
        echo "Seeding Komentar\n";
        for ($i = 0; $i < 30; $i += 1) {
            $review = Komentar::create([
                'komentar' => $faker->sentence(10),
                'review_id' => $reviewTemporary[array_rand($reviewTemporary)]->id,
                'user_id' => $userTemporary[array_rand($userTemporary)]->id
            ]);
        }

        // Tikum
        echo "Seeding Tikum\n";
        for ($i = 0; $i < 30; $i += 1) {
            $review = Tikum::create([
                'tempat_tujuan' => $faker->sentence(2),
                'tempat_kumpul' => $faker->sentence(2),
                'waktu_kumpul' => $faker->dateTime(),
                'link_group' => "https://source.unsplash.com/random",
                'deskripsi' => $faker->paragraph(2),
                'user_id' => $userTemporary[array_rand($userTemporary)]->id
            ]);
        }
    }
}
