<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Variant;
use Faker\Generator as Faker;

$factory->define(Variant::class, function (Faker $faker) {
    return [
        'title' => $faker->randomElement(array('Color', 'Size', 'Style', 'Material', 'Title')),
        'description' => $faker->text
    ];
});
