<?php

namespace App\Enum;

enum AccomodationType: string
{
    case HOTEL = 'hotel';
    case AIRBNB = 'airbnb';
    case CAMPING = 'camping';
    case OTHER = 'other';
}
