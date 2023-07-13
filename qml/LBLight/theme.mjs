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
        radius: borderRadius.lg,
      };
    case 'sm':
      return {
        padding: 8,
        width: 56,
        height: 24,
        radius: borderRadius.sm,
      };
    default:
      return {
        padding: 16,
        width: 76,
        height: 36,
        radius: radius,
      };
  }
}

export function btnStyle(control) {
  let { type, down, enabled, hovered, activeFocus } = control;
  if (!enabled) {
    down = false;
    hovered = false;
  }

  switch (type) {
    case 'primary':
      return {
        backgroundColor: down ? opacity(colors.primary, 90) : colors.primary,
        color: colors.primaryForeground,
        borderColor: colors.primary,
      };
    case 'danger':
      return {
        backgroundColor: down ? opacity(colors.danger, 90) : colors.danger,
        color: colors.dangerForeground,
        borderColor: colors.danger,
      };
    case 'link':
      return {
        backgroundColor: 'transparent',
        color: colors.primary,
        borderColor: 'transparent',
        underline: hovered ? true : false,
      };
    default:
      return {
        backgroundColor: down ? colors.accent : colors.background,
        color: colors.secondaryForeground,
        borderColor: colors.input,
      };
  }
}

export function shadowStyle(control) {
  const { size } = control;

  switch (size) {
    case 'sm':
      return {
        radius: 2,
        color: '#0D000000',
      };
    case 'md':
      return {
        radius: 6,
        color: '#1A000000',
      };
    default:
      return {
        radius: 3,
        color: '#1A000000',
      };
  }
}
