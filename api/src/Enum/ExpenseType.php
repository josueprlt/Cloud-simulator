<?php

namespace App\Enum;

enum ExpenseType: string
{
    case ACTIVITY = 'activity';
    case ACCOMODATION = 'accomodation';
    case OTHER = 'other';

    public static function fromString(string $value): ?self {
        foreach (self::cases() as $case) {
            if ($case->value === $value) {
                return $case;
            }
        }
        return null;
    }

}
