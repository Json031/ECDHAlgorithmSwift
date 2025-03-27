//
//  ECDHAlgorithmSwift.swift
//
//  Created by MorganChen on 2025/3/26.
//

//Default Settings
let defaultGMEllipticCurve: GMEllipticCurve = GMEllipticCurveSecp256r1
let defaultCompressedPublicKey: Bool = true

class ECDHAlgorithmSwift: NSObject {

    private var sharedKey: Data?
    private var gmellipticCurveCrypto: GMEllipticCurveCrypto?
    
    private var gmellipticCurve: GMEllipticCurve = defaultGMEllipticCurve {
        didSet {
            self.gmellipticCurveCrypto = GMEllipticCurveCrypto.generateKeyPair(for: self.gmellipticCurve)
        }
    }
    
    //If false, the public key is 65 bytes, with the first byte being 04. If true, the public key is 32 bytes
    private var compressedPublicKey: Bool = false {
        didSet {
            self.gmellipticCurveCrypto?.compressedPublicKey = self.compressedPublicKey
        }
    }
    
    static let shared = ECDHAlgorithmSwift()

    public func resetGMEllipticCurveCrypto() {
        self.gmellipticCurveCrypto = nil
    }


    /// generate a key pair (64 bytes for public key and 32 bytes for private key)
    /// - Parameters:
    ///   - gmellipticCurve: GMEllipticCurveSecp256r1
    ///   - compressedPublicKey: If false, the public key is 65 bytes, with the first byte being 04. If true, the public key is 32 bytes
    public func generateKeys(gmellipticCurve: GMEllipticCurve, compressedPublicKey: Bool) {
        self.gmellipticCurve = gmellipticCurve;
        self.compressedPublicKey = compressedPublicKey;
    }
    
    /// Obtain the public key and send it to the other party, the other party can get the share key with this public key
    public func getPublicKey() -> Data {
        if (self.gmellipticCurveCrypto == nil) {
            self.generateKeys(gmellipticCurve: defaultGMEllipticCurve, compressedPublicKey: defaultCompressedPublicKey)
        }
        return self.gmellipticCurveCrypto!.publicKey.subdata(in: 1..<self.gmellipticCurveCrypto!.publicKey.count)
    }



    /// After sending one's own public key to the other party, the other party (server or device) returns the processing of the public key
    /// Wait for the other party to notify and send its public key, call configThirdPublicKey to generate a share key by combining the other party's public key with its own private key
    /// - Parameter otherPKStr: the other party public key
    public func generateSharedKeyWithOtherPK(otherPKStr: String) {
        if (self.gmellipticCurveCrypto == nil) {
            generateKeys(gmellipticCurve: defaultGMEllipticCurve, compressedPublicKey: defaultCompressedPublicKey);
        }
        // attach a 0x04 byte to the first byte of the received public key, call the compressPublicKey method to compress it into a 32-bit public key, and then pass it to the sharedSecretForPublicKey method to obtain the shared key
        guard var pData = otherPKStr.data else {
            return
        }
        pData.insert(contentsOf: [CurveCryptoECDHKeyCompressType.notCompress.rawValue], at: 0)
        
        let compressPublicKey = self.gmellipticCurveCrypto?.compressPublicKey(pData)
        //Generate a share key by combining the other party's public key with their own private key
        self.sharedKey = self.gmellipticCurveCrypto?.sharedSecret(forPublicKey: compressPublicKey)
        //send sharedKey to device or server for verification
    }

/// A shared key generated from the public key of another party (server or device) of 64 bytes and its own private key of 32 bytes
    public func getSharedKey() -> Data? {
        if (self.gmellipticCurveCrypto == nil) {
            generateKeys(gmellipticCurve: defaultGMEllipticCurve, compressedPublicKey: defaultCompressedPublicKey);
        }
        return self.sharedKey;
    }
}
