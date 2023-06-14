/* source 04-demo-datetime-format-01-show.sql */
/* Observe the result */
SELECT date_format(now(), '%a %Y-%m-%d %T'),
  date_format(now(), '%Y-%m-%d %r'),
  date_format(now(), '%W, %M %e, %Y'),
  date_format(now(), '%a, %b %e %l:%i %p'),
  date_format(now(), '%d-%b-%Y'),
  date_format('2013-11-23 22:23:00', '%a, %b %e, %Y'),
  date_format(now(), '%M %e, %Y %H:%i'),
  date_format(now(), '%W, the %D of %M') \ G