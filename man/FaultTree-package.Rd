\name{FaultTree-package}
\alias{FaultTree-package}
\docType{package}
\title{
Fault Trees for Risk and Reliability Analysis
}
\description{
A package for constructing,calculating and displaying fault trees.

}

\section{Introduction}{
	\pkg{FaultTree} provides functions for building tree structures as dataframe objects.
	The fault tree incorporates logic nodes (primarily AND and OR) which process input 
	and may direct output "upwards" through the tree structure.  Data is entered through
	component entries.  Component event entries may be active (failures immediately 
	revealed) or dormant (failures remain hidden until activation or inspection).  
	The fault tree may also accept pure probability or pure demand input components.
}

\author{
David J. Silkworth

Maintainer: Jacob T. Ormerod <jake@openreliability.org>
}
\references{
  Ericson, Clifton A. II (2011) Fault Tree Analysis Primer  CreateSpace Inc.
  
  Nicholls, David [Editor] (2005) System Reliability Toolkit  Reliability information Analysis 
  Center
  
  O'Connor, Patrick D.T. (1991) Practical Reliability Engineering  John Wiley & Sons
  
  Vesely, W.E., Goldberg, F.F., Roberts, N.H., Haasl, D.F. (1981)  Fault Tree Handbook
  U.S.  Nuclear Regulatory Commission 
  
  Vesely, W.E., Stamatelato, M., Dugan, J., Fragola, J., Minarick, J., Railsback, J. (2002)
  Fault Tree Handbook with Aerospace Applications   NASA
  
  Doelp, L.C., Lee, G.K., Linney, R.E., Ormsby R.W. (1984) Quantitative fault tree analysis: Gate-by-gate method Plant/Operations Progress
Volume 3, Issue 4 American Institute of Chemical Engineers
}

\keyword{ package }



