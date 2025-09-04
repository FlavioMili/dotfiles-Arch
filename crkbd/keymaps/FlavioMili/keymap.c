/*
Copyright 2019 @foostan
Copyright 2020 Drashna Jaelre <@drashna>

GPLv2 or later.
*/

#include QMK_KEYBOARD_H

enum layers {
    _BASE,
    _FN,
    _SYM,
    _FN2,
};

enum {
    TD_LCTL_LSFT,
    TD_RSFT_RCTL,
    TD_CAPS_ESC,   // Caps double-tap -> Esc
    TD_QUOT_ENT    // ' double-tap -> Enter
};

tap_dance_action_t tap_dance_actions[] = {
    [TD_LCTL_LSFT] = ACTION_TAP_DANCE_DOUBLE(KC_LCTL, KC_LSFT),
    [TD_RSFT_RCTL] = ACTION_TAP_DANCE_DOUBLE(KC_RSFT, KC_RCTL),
    [TD_CAPS_ESC]  = ACTION_TAP_DANCE_DOUBLE(KC_CAPS, KC_ESC), // unused for latency choice.
    [TD_QUOT_ENT]  = ACTION_TAP_DANCE_DOUBLE(KC_QUOT, KC_ENT),
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

    /* Base Layer */
    [_BASE] = LAYOUT_split_3x6_3(
        KC_TAB,  KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                         KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_BSPC,
        KC_ESC, KC_A, KC_S, KC_D,  KC_F,    KC_G,                         KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN, TD(TD_QUOT_ENT),
        TD(TD_LCTL_LSFT), KC_Z, KC_X, KC_C, KC_V,    KC_B,                         KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, TD(TD_RSFT_RCTL),
                                       KC_LGUI,  MO(_SYM), LT(_FN, KC_SPC),   LT(_SYM, KC_ENT),   MO(_FN), KC_LALT
    ),

    /* Function / Media / Numbers (right thumb MO) */
    [_FN] = LAYOUT_split_3x6_3(
        KC_TAB,  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                         KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_BSPC,
        KC_LSFT, _______, _______, _______, _______, _______,                      KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT, _______, _______,
        KC_LCTL, _______, _______, _______, _______, _______,                      _______, _______, _______, _______, _______, _______,
                                           KC_LGUI,  _______, KC_SPC,   KC_ENT,   MO(_FN2), KC_LALT
    ),

    /* Symbols (left thumb MO) */
    [_SYM] = LAYOUT_split_3x6_3(
        KC_TAB,  KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_PERC,                      KC_CIRC, KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN, KC_BSPC,
        KC_LSFT, _______, _______, _______, _______, _______,                      KC_MINS, KC_EQL,  KC_LBRC, KC_RBRC, KC_BSLS, KC_GRV,
        KC_LCTL, _______, _______, _______, _______, _______,                      KC_UNDS, KC_PLUS, KC_LCBR, KC_RCBR, KC_PIPE, KC_TILD,
                                           KC_LGUI,  MO(_SYM), KC_SPC,   KC_ENT,   MO(_FN2), KC_LALT
    ),

    /* F1–F12 / Media */
    [_FN2] = LAYOUT_split_3x6_3(
        KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,                        KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,
        _______, _______, _______, _______, _______, _______,                      KC_MPRV, KC_VOLD, KC_VOLU, KC_MNXT, _______, _______,
        _______, _______, _______, _______, _______, _______,                      _______, _______, _______, _______, _______, _______,
                                           _______, _______, _______,   _______,   _______, _______
    )
};

#ifdef ENCODER_MAP_ENABLE
const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][NUM_DIRECTIONS] = {
    [_BASE] = { ENCODER_CCW_CW(KC_VOLD, KC_VOLU), ENCODER_CCW_CW(KC_MPRV, KC_MNXT) },
    [_FN]   = { ENCODER_CCW_CW(KC_VOLD, KC_VOLU), ENCODER_CCW_CW(KC_MPRV, KC_MNXT) },
    [_SYM]  = { ENCODER_CCW_CW(KC_VOLD, KC_VOLU), ENCODER_CCW_CW(KC_MPRV, KC_MNXT) },
    [_FN2]  = { ENCODER_CCW_CW(KC_TRNS, KC_TRNS), ENCODER_CCW_CW(KC_TRNS, KC_TRNS) },
};
#endif

#ifdef OLED_ENABLE
#include <stdio.h>
#include <oled.c>
#endif
