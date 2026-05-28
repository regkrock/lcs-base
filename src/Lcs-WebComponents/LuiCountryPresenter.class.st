Class {
	#name : 'LuiCountryPresenter',
	#superclass : 'LuiDomainPresenter',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'widgets' }
LuiCountryPresenter >> commonNameWidget [
	^ (self domain slotDefinitionNamed: 'commonName') defaultWidget
]
