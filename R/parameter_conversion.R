## parameter_conversion.R
# copyright 2015-2017, openreliability.org
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#	This function provides a means of calling several parameter conversions that can
#	facilitate scripting of element definitions (mttf, mttr) with parametric characteristics
#	and often for parametized deviate definition on mean values

parameter_conversion<-function(conv, param)  {
	if(is.character(conv)) {
		fun<-switch(conv,
		prob2lam = 1,
		prob2meanw = 2,
		wscale2mean=3,
		wscale2meanw=3,
		meanw2scale=4,
		sigma2ef=5,
		ef2sigma=6,
		meanln2mu=7,
		mean2mu=7,
#		=8,
#		=9,
		stop("conversion calculation not recognized")
		)
	}else{
		fun<-conv
	}
## Exponential distribution as used to define an Exposed basic-event
	if(fun==1) {
		outval<-do.call("prob2lam",list(param[1]))
	}
## Weibull distribution as used to define an Exposed basic-event
	if(fun==2) {
		outval<-do.call("prob2meanw",list(param[1], param[2], param[3]))
	}
	if(fun==3) {
		outval<-do.call("wscale2mean",list(param[1], param[2], param[3]))
	}
	if(fun==4) {
		outval<-do.call("meanw2scale",list(param[1], param[2], param[3]))
	}
## Lognormal distribution as used to define a stochastic deviate
## on some mean parameter of a basic-event
	if(fun==5) {
		outval<-do.call("sigma2ef",list(param[1], param[2]))
	}
	if(fun==6) {
		outval<-do.call("ef2sigma",list(param[1], param[2]))
	}
	if(fun==7) {
		outval<-do.call("meanln2mu",list(param[1], param[2]))
	}

outval
}

pc<-parameter_conversion

#######################################################################
#############     CONVERSION FUNCTIONS     ###########################
#######################################################################

# currently prob2 lam is in a separate file
# prob2lam<-function(prob) {
# if(!exists("mission_time")) {
# stop("mission_time not set")
# }
# exposure<-"mission_time"
# Tao <- eval((parse(text = exposure)))
# lam<-(-1)*log(1-prob)/Tao
# }


prob2meanw<-function(prob, wshape, tzero)  {
if(!exists("mission_time")) {
stop("mission_time not set")
}
exposure<-"mission_time"
Tao <- eval((parse(text = exposure)))
if((Tao-tzero)<0) {
## if SCRAM can handle this then set wmean to zero and proceed with else
	stop("weibull time_shift is greater than mission_time")
#	wmean<-0
 }
#}else{
	wscale<-(Tao-tzero)/((-log(1-prob))^(1/wshape))
	wmean<-wscale*gamma(1+1/wshape)+tzero
#}
wmean
}

wscale2mean<-function(wscale, wshape, tzero) {
	meanw<-wscale*gamma(1+1/wshape)+tzero
	meanw
}


meanw2scale<-function(meanw,wshape,tzero) {
if((meanw-tzero)<0) {
	stop("weibull time_shift is greater than weibull mean")
}
	wscale<-(meanw-tzero)/gamma(1+1/wshape)
	wscale
}


sigma2ef<-function(Lsigma, CL) {
	EF<-exp(Lsigma*qnorm(CL))
	EF
}

ef2sigma<-function(EF, CL)  {
	sigma<-log(EF)/qnorm(CL)
	sigma
}

meanln2mu<-function(meanln, sigma)  {
	mu<-log(meanln)+sigma^2
	mu
}

