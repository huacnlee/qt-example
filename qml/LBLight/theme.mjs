// https://github.com/shadcn/ui/blob/shadcn-ui%400.3.0/apps/www/registry/colors.ts#L1513
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
