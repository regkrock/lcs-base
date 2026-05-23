Class {
	#name : 'LuiExperimentRoot',
	#superclass : 'LuiRoot',
	#instVars : [
		'numtoconvert',
		'result'
	],
	#category : 'Lcs-WebComponentsTests-Experiment',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Experiment'
}

{ #category : 'register' }
LuiExperimentRoot class >> initialize [
	WAAdmin register: self asApplicationAt: 'experiment'
]

{ #category : 'updating' }
LuiExperimentRoot >> applicationTitle [
	^ self class name greaseString
]
