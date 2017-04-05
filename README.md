# datafest

Streamline your ASA DataFest organization workflow with Google forms and R Markdown.


## Using this repo for organizing your DataFest

1. Clone the repository.
2. Make a copy of the [DataFest Organization Google Drive](https://drive.google.com/drive/folders/0B0Y2lFgS9uiDaEZvXzNGZ2xKNmM?usp=sharing).
3. Update [HOST] and [YEAR] in scripts in this repository as well as on the forms in the Google Drive.
4. **Very important!** Note that the `.gitignore` file contains an entry for `.httr-oauth`, make sure to not remove it, especially if you will be storing/sharing your work on a public repository. See the [Managing oauth tokens](https://rawgit.com/jennybc/googlesheets/master/vignettes/managing-auth-tokens.html) vignette, and specifically the D[on't publish your tokens](https://rawgit.com/jennybc/googlesheets/master/vignettes/managing-auth-tokens.html#dont-publish-your-tokens) section for more on this.
5. For info on using the `googlesheets` package, check out [its vignette](https://rawgit.com/jennybc/googlesheets/master/vignettes/basic-usage.html). However the scripts included in this repository should be sufficient to get you going without much additional information.

## Future updates:

1. Add a Google form for post-DataFest feedback collection from participants and one for consultants and judges. Create Rmd files that parse, analyze, and report on findings from these files.
2. Add a scripts for using the `gmailr` package for disseminating information individually to participants (e.g. login info for RStudio / Jupyter notebooks accounts).
3. Make Rmd documents parametrized for host and year- Add info about some wording from Duke info being used
