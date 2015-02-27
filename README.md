# elisp-password-manager

Password manager made for use within emacs. Uses an ido-mode interface to gather your credentials from a specially crafted org-mode table. 

### Example prompt
The prompt subset is reduced in real-time as you type.
```
Which entity? { SoundCloud | Heroku | Github | Facebook | Google | ... }
```

```
Which entity? oo{ Facebook | Google }
```


### Expected table format
The expected format is only important for early releases, as custom column position reading will be implemented with time. The code expects column 1
to be entity and 3 to be password. Other columns are ignored as of now.
```
| entity | username    | password    | Email       | 2F  | Note |
|--------+-------------+-------------+-------------+-----+------|
| Github | ldionmarcil | Tr0ub4dor&3 | foo@bar.com | yes | None |

```