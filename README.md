# DataFest in a Box

Streamline your ASA DataFest organization workflow with Google forms and R Markdown.

Note that the informational documents included here are specifically about the Duke DataFest event. Some sections may not be relevant for events in other locations, but most will be, hence I've provided them for others to easily modify to make their own.

## Using this repo for organizing your DataFest

1. Clone the repository.
2. Make a copy of the [DataFest Organization Google Drive](https://drive.google.com/drive/folders/0B0Y2lFgS9uiDaEZvXzNGZ2xKNmM?usp=sharing).
3. Update [HOST] and [YEAR] in scripts in this repository as well as on the forms in the Google Drive.
4. **Very important!** Note that the `.gitignore` file contains an entry for `.httr-oauth`, make sure to not remove it, especially if you will be storing/sharing your work on a public repository. See the [Managing oauth tokens](https://rawgit.com/jennybc/googlesheets/master/vignettes/managing-auth-tokens.html) vignette, and specifically the D[on't publish your tokens](https://rawgit.com/jennybc/googlesheets/master/vignettes/managing-auth-tokens.html#dont-publish-your-tokens) section for more on this.
5. For info on using the `googlesheets` package, check out [its vignette](https://rawgit.com/jennybc/googlesheets/master/vignettes/basic-usage.html). However the scripts included in this repository should be sufficient to get you going without much additional information.

## What is in this repo?

This repo contains resources for DataFest organizers. Specifically:

- R scripts and R Markdown documents for parsing sign-up data collected via Google Forms.
- R Markdown documents for communicating information to participants, consultants, and judges.

## Questions / comments?

Don't hesitate to send an email to [mine@stat.duke.edu](mailto:mine@stat.duke.edu) with any questions about DataFest.
