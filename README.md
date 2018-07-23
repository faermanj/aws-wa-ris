# Reference Implementations for AWS Well Architected Framework

This project aims to help developers build using the AWS Well Architected Framework. It provides reference implementations and orientations to turn the questions and guidelines from the whitepaper into executables. The framework is designed around non-functional requirements and applicable in general to most customers. This adds implementation suggestions, artifacts and examples that were successful in customers, partners and communities.

The references are presented as jupyter notebooks contaning both the texts and code, making them easy to follow with any AWS account and level of expertise. You should be able to dive as deep as it makes sense for your case, just reading through the documents, running them on your accoount or cherry picking individual components or configurations.

Each answer here is expected to be:

* **Satisficing** over optimizing: Pushing the requirements to their expected levels, not to the state-of-the-art. They may be the same in some cases, but answers and code here aims to be as good as needed, even if not the ultimate best.

* **Objective** over subjective: Each requirement should be demonstrated quantitatively (e.g. latency < 250ms) or sometimess qualitatively (low latency) while missing data and definitions. Exprressing requirements subjectively (high performance, 100% secure, etc) creates ambiquities and makes compliance hard to assess.

* **Durable** over ephemeral: Implementation decisions are frequently lost. Sometime as soon as the requirement is attended and developer start the the next ticket. The notebooks in this repository can be used as a  Lightweight Architectural Decision Record.

* **Shared** over private: Being open and collaborative is great not only for software. Sharing architectural decisions and resources is important and we hope you'll enjoy these.

Get started at [AWS Well Architected Reference Implementations](index.ipynb)


