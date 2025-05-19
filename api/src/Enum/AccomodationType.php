<?php

namespace App\Enum;

enum AccomodationType: string
{
    case HOTEL = 'hotel';
    case AIRBNB = 'airbnb';
    case CAMPING = 'camping';
    case OTHER = 'other';


    public static function fromString(string $value): ?self
    {
        foreach (self::cases() as $case) {
            if ($case->value === $value) {
                return $case;
            }
        }
        return null; // Ou lancez une exception si la valeur n'est pas trouvée
    }
}
