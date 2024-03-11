"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestLcsPrototypeSystem,
	#superclass : #PackageManifest,
	#category : #'Lcs-PrototypeSystem-Manifest'
}

{ #category : #'code-critics' }
ManifestLcsPrototypeSystem class >> ruleJustSendsSuperRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#LxxBarebonesSystem)) #'2024-03-11T12:13:14.398077-04:00') )
]
