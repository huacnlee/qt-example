// https://github.com/shadcn/ui/blob/shadcn-ui%400.3.0/apps/www/registry/colors.ts#L1513
export const radius = 6;
export const inputDefaultWidth = 120;

export const colors = {
  background: '#FFFFFF',
  foreground: '#18181B',
  muted: '#F4F4F5',
  mutedForeground: '#71717A',
  popover: '#FFFFFF',
  popoverForeground: '#18181B',
  border: '#E4E4E7',
  input: '#E4E4E7',
  card: '#FFFFFF',
  cardForeground: '#18181B',
  primary: '#18181B',
  primaryForeground: '#FFFFFF',
  secondary: '#F4F4F5',
  secondaryForeground: '#18181B',
  danger: '#EF4444',
  dangerForeground: '#FFFFFF',
  accent: '#F4F4F5',
  accentForeground: '#18181B',
  focusRing: '#994285F4',
};

export const borderRadius = {
  sm: 4,
  md: 6,
  lg: 8,
};

export const avatarSizes = {
  sm: 24,
  md: 40,
  lg: 56,
};

/**
 *
 * @param {*} hexColor HEX color
 * @param {*} percent lighter percent
 * @returns
 */
export function opacity(hexColor, percent) {
  var opacity = percent / 100;
  var _opacity = Math.round(Math.min(Math.max(opacity || 1, 0), 1) * 255);
  let color = hexColor.replace('#', '');
  return '#' + _opacity.toString(16) + color;
}

export function btnSize(control) {
  const { size } = control;

  switch (size) {
    case 'lg':
      return {
        padding: 24,
        width: 100,
        height: 45,
        iconSize: 16,
        radius: borderRadius.lg,
      };
    case 'sm':
      return {
        padding: 8,
        width: 56,
        height: 24,
        iconSize: 16,
        radius: borderRadius.sm,
      };
    default:
      return {
        padding: 16,
        width: 76,
        height: 36,
        iconSize: 16,
        radius: radius,
      };
  }
}

const btnStyles = {
  primary: {
    backgroundColor: colors.primary,
    activeBackgroundColor: opacity(colors.primary, 90),
    color: colors.primaryForeground,
    borderColor: colors.primary,
    underline: false,
  },
  danger: {
    backgroundColor: colors.danger,
    activeBackgroundColor: opacity(colors.danger, 90),
    color: colors.dangerForeground,
    borderColor: colors.danger,
    underline: false,
  },
  link: {
    backgroundColor: 'transparent',
    activeBackgroundColor: 'transparent',
    color: colors.primary,
    borderColor: 'transparent',
    underline: false,
  },
  checked: {
    backgroundColor: colors.accent,
    activeBackgroundColor: colors.accent,
    color: colors.secondaryForeground,
    borderColor: colors.accent,
  },
  default: {
    backgroundColor: colors.background,
    activeBackgroundColor: colors.accent,
    color: colors.secondaryForeground,
    borderColor: colors.input,
    underline: false,
  },
};

export function btnStyle(control) {
  let { type, down, enabled, hovered, activeFocus, checked } = control;
  if (!enabled) {
    down = false;
    hovered = false;
  }
  if (checked) {
    hovered = false;
  }

  if (checked) {
    return btnStyles.checked;
  }

  let style = Object.assign({}, btnStyles[type] || btnStyles.default);
  if (down) {
    style.backgroundColor = style.activeBackgroundColor;
  }
  if (hovered && type === 'link') {
    style.underline = true;
  }

  return style;
}

export function shadowStyle(control) {
  const { size } = control;

  switch (size) {
    case 'sm':
      return {
        radius: 2,
        verticalOffset: 1,
        color: '#0D000000',
      };

    case 'md':
      return {
        radius: 5,
        verticalOffset: 1,
        color: '#1A000000',
      };
    default:
    case 'lg':
      return {
        radius: 8,
        verticalOffset: 3,
        color: '#1A000000',
      };
  }
}
