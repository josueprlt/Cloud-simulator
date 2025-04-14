<?php

namespace App\Enum;

enum ExpenseType: string
{
    case ACTIVITY = 'activity';
    case ACCOMODATION = 'accomodation';
    case OTHER = 'other';
}
